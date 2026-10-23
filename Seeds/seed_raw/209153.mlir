module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-148> : tensor<10xi64>}> : () -> tensor<10xi64>
    %1 = "tosa.const"() <{values = dense<-1.056900e+02> : tensor<5x4x1x6xf32>}> : () -> tensor<5x4x1x6xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<10xi64>) -> tensor<1xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.transpose %2 {perms = array<i32: 0>} : (tensor<1xi64>) -> tensor<1xi64>
    %5 = tosa.bitwise_xor %4, %2 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %6 = tosa.tanh %1 : (tensor<5x4x1x6xf32>) -> tensor<5x4x1x6xf32>
    %7 = tosa.bitwise_or %5, %2 : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %8 = tosa.maximum %6, %6 : (tensor<5x4x1x6xf32>, tensor<5x4x1x6xf32>) -> tensor<5x4x1x6xf32>
    %9 = tosa.reciprocal %8 : (tensor<5x4x1x6xf32>) -> tensor<5x4x1x6xf32>
    %10 = tosa.log %8 : (tensor<5x4x1x6xf32>) -> tensor<5x4x1x6xf32>
    %cast = tensor.cast %7 : tensor<1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %9 : tensor<5x4x1x6xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<5x4x1x6xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

