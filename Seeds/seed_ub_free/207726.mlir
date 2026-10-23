module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<1xi8>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<i32>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

