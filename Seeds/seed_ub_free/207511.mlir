module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<115> : tensor<7x8x6x7xi32>}> : () -> tensor<7x8x6x7xi32>
    %1 = "tosa.const"() <{values = dense<152> : tensor<1x8x6x7xi32>}> : () -> tensor<1x8x6x7xi32>
    %2 = tosa.add %0, %1 : (tensor<7x8x6x7xi32>, tensor<1x8x6x7xi32>) -> tensor<7x8x6x7xi32>
    %cast = tensor.cast %2 : tensor<7x8x6x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

