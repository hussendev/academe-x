
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_multi_choice_widget.dart';
import 'file_container.dart';

class CreatePost {
  final TextEditingController _postController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void showCreatePostModal(BuildContext parContext) {
    showModalBottomSheet(
      context: parContext,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16   )),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Modal height factor
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 24   ,
              right: 24   ,
              top: 16
            ), // Adjust for keyboard and padding
            child: SingleChildScrollView(
              child: SizedBox(
                height: 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top handle to indicate drag
                    Center(
                      child: Container(
                        width: 56   ,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Color(0xffE7E8EA),
                          borderRadius: BorderRadius.circular(12   ),
                        ),
                      ),
                    ),
                    16.ph(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'الغاء',
                          fontSize: 14  ,
                          color: Colors.green,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        AppText(
                          text: 'إنشاء بوست',
                          fontSize: 16  ,
                          fontWeight: FontWeight.w600,
                        ),
                        // You can add another icon or widget here if needed
                        SizedBox(width: 50   ), // Placeholder for alignment
                      ],
                    ),
                    16.ph(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20   ,
                          child: AppText(
                            text: 'إ',
                            fontSize: 15  ,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8   ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: 'إبراهيم',
                              fontSize: 14  ,
                              fontWeight: FontWeight.w600,
                            ),
                            AppText(
                              text: '#تطوير البرمجيات',
                              fontSize: 12  ,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      withBoarder: false,
                      maxLine: null,
                      controller: _postController,
                      hintText: 'قم بكتابة ما تريد الاستفسار عنه ..',
                      keyboardType: TextInputType.multiline,
                      focusNode: _focusNode,
                      suffix: GestureDetector(
                        onTap: () {
                          _postController.clear();
                        },
                        child: Icon(Icons.clear, color: Colors.grey),
                      ),
                    ),
                    // need if statment as : if(textController.isNotEmpty) do the loop
                    // for loop for the hashes
                    for (int i = 0; i < 1; i++)
                      AppText(
                        text: '   ' + '#تطوير برمجيات',
                        fontSize: 14  ,
                        color: const Color(0xff0077FF),
                      ),
                    SizedBox(height: 16.h),
                    BlocBuilder<PickerCubit, CreatePostIconsState>(
                      builder: (context, state) {
                        if (state is ImagePickerLoaded) {
                          return Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                for (int index = 0;
                                    index < state.images.length;
                                    index++)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 9   ),
                                    height: 178,
                                    width: state.images.length == 1 ? 300    : 178   ,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      image: DecorationImage(
                                        image: FileImage(state.images[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ]),
                            ),
                          );
                        } else if (state is FilePickerLoaded) {
                          return FileContainer(file: state.file);
                        } else if (state is CreateMultiChoice) {
                          return CreateMultiChoiceWidget();
                        } else {
                          return 0.ph();
                        }
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon:
                              const ImageIcon(AssetImage('assets/icons/image.png')),
                          onPressed: () {
                            context.read<PickerCubit>().pickImage();
                          },
                        ),
                        IconButton(
                          icon: const ImageIcon(
                              AssetImage('assets/icons/document.png')),
                          onPressed: () {
                            context.read<PickerCubit>().pickFile();
                          },
                        ),
                        IconButton(
                          icon:
                              const ImageIcon(AssetImage('assets/icons/menu.png')),
                          onPressed: () {
                            context.read<PickerCubit>().createMulteChoice();
                          },
                        ),
                        IconButton(
                          icon:
                              const ImageIcon(AssetImage('assets/icons/hash.png')),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Handle post submission
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              Color(0xFF007AFF), // Blue color for the post button
                          borderRadius: BorderRadius.circular(10   ),
                        ),
                        child: Center(
                          child: AppText(
                            text: 'نشر',
                            fontSize: 16  ,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    20.ph(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
