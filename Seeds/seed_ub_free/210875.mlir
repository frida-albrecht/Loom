module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<178> : tensor<6xi16>}> : () -> tensor<6xi16>
    %1 = "tosa.const"() <{values = dense<-5.969000e+01> : tensor<9x7xf32>}> : () -> tensor<9x7xf32>
    %2 = "tosa.const"() <{values = dense<1.686600e+02> : tensor<1x7xf32>}> : () -> tensor<1x7xf32>
    %3 = tosa.reverse %0 {axis = 0 : i32} : (tensor<6xi16>) -> tensor<6xi16>
    %4 = tosa.add %3, %3 : (tensor<6xi16>, tensor<6xi16>) -> tensor<6xi16>
    %5 = tosa.bitwise_and %4, %4 : (tensor<6xi16>, tensor<6xi16>) -> tensor<6xi16>
    %a1 = tosa.abs %1 : (tensor<9x7xf32>) -> tensor<9x7xf32>
    %6 = tosa.pow %a1, %2 : (tensor<9x7xf32>, tensor<1x7xf32>) -> tensor<9x7xf32>
    %7 = tosa.log %6 : (tensor<9x7xf32>) -> tensor<9x7xf32>
    %8 = tosa.log %6 : (tensor<9x7xf32>) -> tensor<9x7xf32>
    %cast = tensor.cast %5 : tensor<6xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<9x7xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<9x7xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}