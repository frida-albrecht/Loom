module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.443700e+02> : tensor<8x2x4xf32>}> : () -> tensor<8x2x4xf32>
    %1 = "tosa.const"() <{values = dense<140> : tensor<6xi64>}> : () -> tensor<6xi64>
    %2 = "tosa.const"() <{values = dense<-132> : tensor<1xi64>}> : () -> tensor<1xi64>
    %3 = tosa.tanh %0 : (tensor<8x2x4xf32>) -> tensor<8x2x4xf32>
    %4 = tosa.ceil %3 : (tensor<8x2x4xf32>) -> tensor<8x2x4xf32>
    %5 = tosa.reciprocal %4 : (tensor<8x2x4xf32>) -> tensor<8x2x4xf32>
    %6 = tosa.identity %5 : (tensor<8x2x4xf32>) -> tensor<8x2x4xf32>
    %7 = tosa.bitwise_and %1, %2 : (tensor<6xi64>, tensor<1xi64>) -> tensor<6xi64>
    %8 = tosa.maximum %6, %5 : (tensor<8x2x4xf32>, tensor<8x2x4xf32>) -> tensor<8x2x4xf32>
    %cast = tensor.cast %7 : tensor<6xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %8 : tensor<8x2x4xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

