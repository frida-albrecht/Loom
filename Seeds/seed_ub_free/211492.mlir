module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<115> : tensor<5x7x7x8xi32>}> : () -> tensor<5x7x7x8xi32>
    %1 = "tosa.const"() <{values = dense<23> : tensor<5x7x1x8xi32>}> : () -> tensor<5x7x1x8xi32>
    %2 = tosa.minimum %0, %1 : (tensor<5x7x7x8xi32>, tensor<5x7x1x8xi32>) -> tensor<5x7x7x8xi32>
    %3 = tosa.bitwise_and %2, %2 : (tensor<5x7x7x8xi32>, tensor<5x7x7x8xi32>) -> tensor<5x7x7x8xi32>
    %4 = tosa.abs %3 : (tensor<5x7x7x8xi32>) -> tensor<5x7x7x8xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.negate %4, %5, %6 : (tensor<5x7x7x8xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<5x7x7x8xi32>
    %8 = tosa.minimum %7, %4 : (tensor<5x7x7x8xi32>, tensor<5x7x7x8xi32>) -> tensor<5x7x7x8xi32>
    %9 = tosa.bitwise_not %8 : (tensor<5x7x7x8xi32>) -> tensor<5x7x7x8xi32>
    %cast = tensor.cast %9 : tensor<5x7x7x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

