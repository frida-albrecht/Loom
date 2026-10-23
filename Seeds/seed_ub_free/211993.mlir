module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.907500e+02> : tensor<10xf32>}> : () -> tensor<10xf32>
    %1 = "tosa.const"() <{values = dense<-136> : tensor<3x3x5x6xi64>}> : () -> tensor<3x3x5x6xi64>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1x1x1x1xi64>}> : () -> tensor<1x1x1x1xi64>
    %3 = tosa.reciprocal %0 : (tensor<10xf32>) -> tensor<10xf32>
    %4 = tosa.const_shape  {values = dense<10> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.reshape %3, %4 : (tensor<10xf32>, !tosa.shape<1>) -> tensor<10xf32>
    %6 = tosa.add %5, %3 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %7 = tosa.identity %6 : (tensor<10xf32>) -> tensor<10xf32>
    %8 = tosa.reciprocal %7 : (tensor<10xf32>) -> tensor<10xf32>
    %9 = tosa.identity %8 : (tensor<10xf32>) -> tensor<10xf32>
    %10 = tosa.bitwise_and %1, %2 : (tensor<3x3x5x6xi64>, tensor<1x1x1x1xi64>) -> tensor<3x3x5x6xi64>
    %11 = tosa.bitwise_not %10 : (tensor<3x3x5x6xi64>) -> tensor<3x3x5x6xi64>
    %cast = tensor.cast %9 : tensor<10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<3x3x5x6xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

