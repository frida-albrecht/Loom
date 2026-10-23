module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<184> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<147> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<-186> : tensor<3x1xi64>}> : () -> tensor<3x1xi64>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %4 = tosa.reverse %2 {axis = 0 : i32} : (tensor<3x1xi64>) -> tensor<3x1xi64>
    %5 = tosa.minimum %4, %4 : (tensor<3x1xi64>, tensor<3x1xi64>) -> tensor<3x1xi64>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %8 = tosa.negate %5, %6, %7 : (tensor<3x1xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<3x1xi64>
    %9 = tosa.sub %4, %5 : (tensor<3x1xi64>, tensor<3x1xi64>) -> tensor<3x1xi64>
    %10 = tosa.add %9, %9 : (tensor<3x1xi64>, tensor<3x1xi64>) -> tensor<3x1xi64>
    %11 = tosa.logical_right_shift %8, %9 : (tensor<3x1xi64>, tensor<3x1xi64>) -> tensor<3x1xi64>
    %12 = tosa.concat %10, %9 {axis = 0 : i32} : (tensor<3x1xi64>, tensor<3x1xi64>) -> tensor<6x1xi64>
    %13 = tosa.const_shape  {values = dense<[6, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %14 = tosa.reshape %12, %13 : (tensor<6x1xi64>, !tosa.shape<2>) -> tensor<6x1xi64>
    %15 = tosa.minimum %11, %9 : (tensor<3x1xi64>, tensor<3x1xi64>) -> tensor<3x1xi64>
    %cast = tensor.cast %3 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %14 : tensor<6x1xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %15 : tensor<3x1xi64> to tensor<*xi64>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}

