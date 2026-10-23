module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<104> : tensor<3x10x1xi32>}> : () -> tensor<3x10x1xi32>
    %1 = tosa.reverse %0 {axis = 2 : i32} : (tensor<3x10x1xi32>) -> tensor<3x10x1xi32>
    %cast = tensor.cast %1 : tensor<3x10x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

