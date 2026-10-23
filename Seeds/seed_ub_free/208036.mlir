module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-169> : tensor<3x5xi64>}> : () -> tensor<3x5xi64>
    %1 = "tosa.const"() <{values = dense<1.890200e+02> : tensor<2x9x10x2xf32>}> : () -> tensor<2x9x10x2xf32>
    %2 = "tosa.const"() <{values = dense<1.851000e+02> : tensor<1x1x10x2xf32>}> : () -> tensor<1x1x10x2xf32>
    %3 = tosa.reverse %0 {axis = 0 : i32} : (tensor<3x5xi64>) -> tensor<3x5xi64>
    %4 = tosa.abs %3 : (tensor<3x5xi64>) -> tensor<3x5xi64>
    %5 = tosa.pow %1, %2 : (tensor<2x9x10x2xf32>, tensor<1x1x10x2xf32>) -> tensor<2x9x10x2xf32>
    %6 = tosa.minimum %5, %5 : (tensor<2x9x10x2xf32>, tensor<2x9x10x2xf32>) -> tensor<2x9x10x2xf32>
    %cast = tensor.cast %4 : tensor<3x5xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<2x9x10x2xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

