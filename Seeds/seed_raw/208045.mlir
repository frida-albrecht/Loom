module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<10x9xi8>}> : () -> tensor<10x9xi8>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<10x9xi8>) -> tensor<9xi32>
    %cast = tensor.cast %1 : tensor<9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

