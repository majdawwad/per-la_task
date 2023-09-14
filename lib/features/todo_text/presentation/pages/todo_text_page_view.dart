import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/todo_text.dart';
import '../bloc/todo_text/todo_text_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../dependency_injection.dart' as di;
import '../../../../core/app_theme/app_text_style.dart';
import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/constants/app_assets_route.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/extentions/media_query.dart';
import '../../../../core/widgets/text_form_field_widget.dart';
import '../widgets/app_drawer_widget.dart';
import '../widgets/drawer_button_widget.dart';

class TodoTextPageView extends StatefulWidget {
  const TodoTextPageView({Key? key}) : super(key: key);

  @override
  State<TodoTextPageView> createState() => _TodoTextPageViewState();
}

class _TodoTextPageViewState extends State<TodoTextPageView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textUpdateFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerWidget(sharedPreferences: di.sl<SharedPreferences>()),
      body: Builder(builder: (context) {
        return ListView(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: DrawerButtonWidget(
                onTap: () => Scaffold.of(context).openDrawer(),
                imagePath: AppAssetsRoute.menuClose,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.paddingTwenty.w,
                vertical: AppPadding.paddingfifty.h,
              ),
              child: Row(
                children: [
                  Form(
                    key: _formKey,
                    child: Expanded(
                      child: TextFormFieldWidget(
                        textEditingController: _textController,
                        hintText: 'Enter your text',
                        filled: true,
                       
                        keyboardType: TextInputType.text,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return "You must to enter your text";
                          } else if (value.isNotEmpty && value.length < 10) {
                            return "The name must not to be smaller than ten characters";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  SizedBox(
                    height: context.screenHeight / 13.5,
                    child: BlocConsumer<TodoTextBloc, TodoTextState>(
                      listener: (context, state) {
                        if (state is LoadTodosTextsState) {
                          SnackBarMessage.snackBarSuccessMessage(
                            context: context,
                            message: state.message,
                          );
                        } else if (state is ErrorTodosTextsState) {
                          SnackBarMessage.snackBarErrorMessage(
                            context: context,
                            message: state.message,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadingTodosTextsState) {
                          return const LoadingWidget();
                        }
                        return OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              TodoText todoText = TodoText(
                                text: _textController.text.trim(),
                                date: "2023-07-25",
                              );

                              context
                                  .read<TodoTextBloc>()
                                  .add(AddTodoTextEvent(todoText: todoText));
                              context
                                  .read<TodoTextBloc>()
                                  .add(GetAllTodosTextsEvent());
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(defaultRadius.r)),
                              ),
                            ),
                          ),
                          child: Text(
                            "Add",
                            style: AppTextStyle.textStyle4,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            BlocConsumer<TodoTextBloc, TodoTextState>(
              listener: (context, state) {
                if (state is LoadTodosTextsState) {
                  SnackBarMessage.snackBarSuccessMessage(
                    context: context,
                    message: state.message,
                  );
                } else if (state is ErrorTodosTextsState) {
                  SnackBarMessage.snackBarErrorMessage(
                    context: context,
                    message: state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadingTodosTextsState) {
                  return const LoadingWidget();
                } else if (state is ErrorTodosTextsState) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppTextStyle.textStyle2,
                    ),
                  );
                } else if (state is LoadedTodosTextsState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.paddingTwenty.w,
                    ),
                    child: DataTable(
                      showCheckboxColumn: false,
                      headingRowColor:
                          const MaterialStatePropertyAll(foregroundColor),
                      dividerThickness: 0.3,
                      border: TableBorder(
                        top: BorderSide(
                          width: 2.0.w,
                          color: foregroundColor,
                        ),
                        left: BorderSide(
                          width: 1.0.w,
                          color: lightGrey1,
                        ),
                        right: BorderSide(
                          width: 1.0.w,
                          color: lightGrey1,
                        ),
                        bottom: BorderSide(
                          width: 1.0.w,
                          color: lightGrey1,
                        ),
                      ),
                      columnSpacing: 10,
                      columns: [
                        DataColumn(
                          label: Text(
                            'Text',
                            style: AppTextStyle.textStyle8,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date',
                            style: AppTextStyle.textStyle8,
                          ),
                        ),
                        const DataColumn(label: Text('')),
                        const DataColumn(label: Text('')),
                      ],
                      rows: state.todosTests
                          .map((e) => DataRow(cells: [
                                DataCell(
                                  Text(
                                    e.text.toString(),
                                    style: AppTextStyle.textStyle9,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.date,
                                    style: AppTextStyle.textStyle9,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      _textUpdateFieldController.text = e.text;
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Edit on Todo',
                                                style: AppTextStyle.textStyle3,
                                              ),
                                              content: Form(
                                                key: _formKey1,
                                                child: TextFormFieldWidget(
                                                  textEditingController:
                                                      _textUpdateFieldController,
                                                  hintText: 'Enter your text',
                                                  filled: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validation: (value) {
                                                    if (value!.isEmpty) {
                                                      return "You must to enter your text";
                                                    } else if (value
                                                            .isNotEmpty &&
                                                        value.length < 10) {
                                                      return "The name must not to be smaller than ten characters";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                  style: ButtonStyle(
                                                    shape:
                                                        MaterialStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    defaultRadius
                                                                        .r)),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Cancel",
                                                    style:
                                                        AppTextStyle.textStyle4,
                                                  ),
                                                ),
                                                BlocConsumer<TodoTextBloc,
                                                    TodoTextState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is LoadTodosTextsState) {
                                                      SnackBarMessage
                                                          .snackBarSuccessMessage(
                                                        context: context,
                                                        message: state.message,
                                                      );
                                                    } else if (state
                                                        is ErrorTodosTextsState) {
                                                      SnackBarMessage
                                                          .snackBarErrorMessage(
                                                        context: context,
                                                        message: state.message,
                                                      );
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    if (state
                                                        is LoadingTodosTextsState) {
                                                      return const LoadingWidget();
                                                    }
                                                    return OutlinedButton(
                                                      onPressed: () {
                                                        if (_formKey1
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();

                                                          TodoText todoText =
                                                              TodoText(
                                                            id: e.id,
                                                            text:
                                                                _textUpdateFieldController
                                                                    .text
                                                                    .trim(),
                                                            date: "2023-08-27",
                                                          );

                                                          context
                                                              .read<
                                                                  TodoTextBloc>()
                                                              .add(UpdateTodoTextEvent(
                                                                  todoText:
                                                                      todoText));
                                                          context
                                                              .read<
                                                                  TodoTextBloc>()
                                                              .add(
                                                                  GetAllTodosTextsEvent());
                                                          context.pop();
                                                        }
                                                      },
                                                      style: ButtonStyle(
                                                        shape:
                                                            MaterialStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        defaultRadius
                                                                            .r)),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Update",
                                                        style: AppTextStyle
                                                            .textStyle4,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Image.asset(
                                      AppAssetsRoute.edit,
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      context.read<TodoTextBloc>().add(
                                          DeleteTodoTextEvent(
                                              todoTextId: e.id!));
                                      context
                                          .read<TodoTextBloc>()
                                          .add(GetAllTodosTextsEvent());
                                    },
                                    child: Image.asset(
                                      AppAssetsRoute.delete,
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                  ),
                                ),
                              ]))
                          .toList(),
                    ),
                  );
                }
                return const LoadingWidget();
              },
            ),
          ],
        );
      }),
    );
  }
}
