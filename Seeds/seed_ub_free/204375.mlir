module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<134> : tensor<6x8xi64>}> : () -> tensor<6x8xi64>
    %1 = "tosa.const"() <{values = dense<-9.770000e+00> : tensor<5x1x9x10xf32>}> : () -> tensor<5x1x9x10xf32>
    %2 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<6x8xi64>) -> tensor<6x1xi64>
    %3 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<6x1xi64>) -> tensor<6x1xi64>
    %4 = tosa.reciprocal %1 : (tensor<5x1x9x10xf32>) -> tensor<5x1x9x10xf32>
    %5 = tosa.reciprocal %4 : (tensor<5x1x9x10xf32>) -> tensor<5x1x9x10xf32>
    %6 = tosa.bitwise_xor %3, %3 : (tensor<6x1xi64>, tensor<6x1xi64>) -> tensor<6x1xi64>
    %7 = tosa.maximum %4, %5 : (tensor<5x1x9x10xf32>, tensor<5x1x9x10xf32>) -> tensor<5x1x9x10xf32>
    %cast = tensor.cast %6 : tensor<6x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<5x1x9x10xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

