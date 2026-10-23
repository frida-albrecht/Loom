module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-80> : tensor<8x5x9x5xi32>}> : () -> tensor<8x5x9x5xi32>
    %1 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<8x5x9x5xi32>) -> tensor<8x1x9x5xi32>
    %2 = tosa.sub %1, %1 : (tensor<8x1x9x5xi32>, tensor<8x1x9x5xi32>) -> tensor<8x1x9x5xi32>
    %cast = tensor.cast %2 : tensor<8x1x9x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

