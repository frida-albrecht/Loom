module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<7x5xi1>}> : () -> tensor<7x5xi1>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<7x5xi1>) -> tensor<5xi32>
    %cast = tensor.cast %1 : tensor<5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

