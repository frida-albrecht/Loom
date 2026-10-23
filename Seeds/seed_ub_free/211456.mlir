module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.377300e+02> : tensor<9x1xf32>}> : () -> tensor<9x1xf32>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<9x1xf32>) -> tensor<9xi32>
    %cast = tensor.cast %1 : tensor<9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

