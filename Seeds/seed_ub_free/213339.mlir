module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<45> : tensor<10x5x10x7xi32>}> : () -> tensor<10x5x10x7xi32>
    %1 = "tosa.const"() <{values = dense<1.225000e+02> : tensor<7x9x6x9xf32>}> : () -> tensor<7x9x6x9xf32>
    %2 = tosa.bitwise_not %0 : (tensor<10x5x10x7xi32>) -> tensor<10x5x10x7xi32>
    %3 = tosa.bitwise_or %2, %2 : (tensor<10x5x10x7xi32>, tensor<10x5x10x7xi32>) -> tensor<10x5x10x7xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<10x5x10x7xi32>}> : () -> tensor<10x5x10x7xi32>
    %clamped_lower = tosa.maximum %3, %c0 : (tensor<10x5x10x7xi32>, tensor<10x5x10x7xi32>) -> tensor<10x5x10x7xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<10x5x10x7xi32>}> : () -> tensor<10x5x10x7xi32>
    %clamped_shift = tosa.minimum %clamped_lower, %c31 : (tensor<10x5x10x7xi32>, tensor<10x5x10x7xi32>) -> tensor<10x5x10x7xi32>
    %4 = tosa.arithmetic_right_shift %3, %clamped_shift {round = true} : (tensor<10x5x10x7xi32>, tensor<10x5x10x7xi32>) -> tensor<10x5x10x7xi32>
    %5 = tosa.reciprocal %1 : (tensor<7x9x6x9xf32>) -> tensor<7x9x6x9xf32>
    %cast = tensor.cast %4 : tensor<10x5x10x7xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<7x9x6x9xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}