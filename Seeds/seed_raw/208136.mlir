module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<8x3xi8>}> : () -> tensor<8x3xi8>
    %1 = tosa.clz %0 : (tensor<8x3xi8>) -> tensor<8x3xi8>
    %2 = tosa.abs %1 : (tensor<8x3xi8>) -> tensor<8x3xi8>
    %3 = tosa.abs %2 : (tensor<8x3xi8>) -> tensor<8x3xi8>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<8x3xi8>) -> tensor<3xi32>
    %cast = tensor.cast %4 : tensor<3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

