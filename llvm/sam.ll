@s1 = constant [51 x i8] c"Hi!\0a- Name: Kushagra Agarwal\0a- Srn: PES2UG22CS275\0a\00"

declare i32 @printf(i8*, ...)

define i32 @main() {
  %s1_ptr = getelementptr [51 x i8], [51 x i8]* @s1, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %s1_ptr)
  ret i32 0
}