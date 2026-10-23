module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-21> : tensor<8x2x8xi32>}> : () -> tensor<8x2x8xi32>
    %1 = "tosa.const"() <{values = dense<32> : tensor<1x2x1xi32>}> : () -> tensor<1x2x1xi32>
    %2 = tosa.maximum %0, %1 : (tensor<8x2x8xi32>, tensor<1x2x1xi32>) -> tensor<8x2x8xi32>
    %3 = tosa.reverse %2 {axis = 1 : i32} : (tensor<8x2x8xi32>) -> tensor<8x2x8xi32>
    %cast = tensor.cast %3 : tensor<8x2x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

