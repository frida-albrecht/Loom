module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<7x10x2x4xi8>}> : () -> tensor<7x10x2x4xi8>
    %1 = tosa.argmax %0 {axis = 2 : i32} : (tensor<7x10x2x4xi8>) -> tensor<7x10x4xi32>
    %cast = tensor.cast %1 : tensor<7x10x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

