module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-25> : tensor<3x10x3x3xi64>}> : () -> tensor<3x10x3x3xi64>
    %1 = "tosa.const"() <{values = dense<-9.648000e+01> : tensor<2x10x2xf32>}> : () -> tensor<2x10x2xf32>
    %2 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<3x10x3x3xi64>) -> tensor<1x10x3x3xi64>
    %3 = tosa.tanh %1 : (tensor<2x10x2xf32>) -> tensor<2x10x2xf32>
    %4 = tosa.argmax %2 {axis = 1 : i32} : (tensor<1x10x3x3xi64>) -> tensor<1x3x3xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.negate %4, %5, %6 : (tensor<1x3x3xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1x3x3xi32>
    %cast = tensor.cast %3 : tensor<2x10x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<1x3x3xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

