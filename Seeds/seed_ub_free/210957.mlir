module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-141> : tensor<6x4x5xi32>}> : () -> tensor<6x4x5xi32>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<6x4x5xi32>) -> tensor<4x5xi32>
    %2 = tosa.clz %1 : (tensor<4x5xi32>) -> tensor<4x5xi32>
    %cast = tensor.cast %2 : tensor<4x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

