module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<9x10x2x5xi16>}> : () -> tensor<9x10x2x5xi16>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<9x10x2x5xi16>) -> tensor<9x2x5xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.negate %1, %2, %3 : (tensor<9x2x5xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<9x2x5xi32>
    %cast = tensor.cast %4 : tensor<9x2x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

