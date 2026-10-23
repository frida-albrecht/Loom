module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<106> : tensor<7x3x3xi64>}> : () -> tensor<7x3x3xi64>
    %1 = "tosa.const"() <{values = dense<-54> : tensor<7x3x10xi64>}> : () -> tensor<7x3x10xi64>
    %2 = "tosa.const"() <{values = dense<1.039800e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<7x3x3xi64>, tensor<7x3x10xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<7x3x10xi64>
    %6 = tosa.ceil %2 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.minimum %5, %5 : (tensor<7x3x10xi64>, tensor<7x3x10xi64>) -> tensor<7x3x10xi64>
    %8 = tosa.const_shape  {values = dense<[1, 210]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %9 = tosa.reshape %7, %8 : (tensor<7x3x10xi64>, !tosa.shape<2>) -> tensor<1x210xi64>
    %cast = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<1x210xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

