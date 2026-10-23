module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.887000e+01> : tensor<6x9x1x3xf32>}> : () -> tensor<6x9x1x3xf32>
    %1 = "tosa.const"() <{values = dense<122> : tensor<8x6x10x1xi64>}> : () -> tensor<8x6x10x1xi64>
    %2 = "tosa.const"() <{values = dense<131> : tensor<1x6x1x1xi64>}> : () -> tensor<1x6x1x1xi64>
    %3 = tosa.tanh %0 : (tensor<6x9x1x3xf32>) -> tensor<6x9x1x3xf32>
    %4 = tosa.logical_left_shift %1, %2 : (tensor<8x6x10x1xi64>, tensor<1x6x1x1xi64>) -> tensor<8x6x10x1xi64>
    %5 = tosa.reduce_product %3 {axis = 1 : i32} : (tensor<6x9x1x3xf32>) -> tensor<6x1x1x3xf32>
    %cast = tensor.cast %4 : tensor<8x6x10x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<6x1x1x3xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

