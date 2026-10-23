module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-86> : tensor<9x7x1x8xi32>}> : () -> tensor<9x7x1x8xi32>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<9x7x1x8xi32>) -> tensor<7x1x8xi32>
    %2 = tosa.bitwise_not %1 : (tensor<7x1x8xi32>) -> tensor<7x1x8xi32>
    %cast = tensor.cast %2 : tensor<7x1x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

