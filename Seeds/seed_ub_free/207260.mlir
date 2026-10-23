module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-94> : tensor<8x9x6x3xi64>}> : () -> tensor<8x9x6x3xi64>
    %1 = "tosa.const"() <{values = dense<-179> : tensor<8x9x1x3xi64>}> : () -> tensor<8x9x1x3xi64>
    %2 = "tosa.const"() <{values = dense<-1.359700e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.maximum %0, %1 : (tensor<8x9x6x3xi64>, tensor<8x9x1x3xi64>) -> tensor<8x9x6x3xi64>
    %4 = tosa.floor %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<8x9x6x3xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

