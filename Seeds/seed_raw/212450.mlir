module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-30> : tensor<9x9xi16>}> : () -> tensor<9x9xi16>
    %1 = tosa.clz %0 : (tensor<9x9xi16>) -> tensor<9x9xi16>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<9x9xi16>) -> tensor<9xi32>
    %cast = tensor.cast %2 : tensor<9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

