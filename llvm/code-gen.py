llvm_global = """@s1 = constant [51 x i8] c"Hi!\\0a- Name: Kushagra Agarwal\\0a- Srn: PES2UG22CS275\\0a\\00"
declare i32 @printf(i8*, ...)
"""

llvm_main = """define i32 @main() {
%name = getelementptr [51 x i8], [51 x i8]* @s1, i32 0, i32 0
"""

llvm_print = """
  call i32 (i8*, ...) @printf(i8* %name)
"""

llvm_ret = """
  ret i32 0
}
"""

with open("output.ll", "w") as file:
    file.write(llvm_global)
    file.write(llvm_main)
    file.write(llvm_print)
    file.write(llvm_print)
    file.write(llvm_print)
    file.write(llvm_print)
    file.write(llvm_print)
    file.write(llvm_ret)

