module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<121> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = tosa.clz %0 : (tensor<1xi32>) -> tensor<1xi32>
    %2 = tosa.bitwise_xor %1, %1 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %2 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

