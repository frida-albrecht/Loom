module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-86> : tensor<8x10x9x1xi16>}> : () -> tensor<8x10x9x1xi16>
    %1 = tosa.reverse %0 {axis = 3 : i32} : (tensor<8x10x9x1xi16>) -> tensor<8x10x9x1xi16>
    %2 = tosa.bitwise_not %1 : (tensor<8x10x9x1xi16>) -> tensor<8x10x9x1xi16>
    %3 = tosa.argmax %2 {axis = 2 : i32} : (tensor<8x10x9x1xi16>) -> tensor<8x10x1xi32>
    %cast = tensor.cast %3 : tensor<8x10x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

