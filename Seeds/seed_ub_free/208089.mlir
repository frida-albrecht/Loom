module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.723800e+02> : tensor<5x3x9xf32>}> : () -> tensor<5x3x9xf32>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<5x3x9xf32>) -> tensor<3x9xi32>
    %cast = tensor.cast %1 : tensor<3x9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

