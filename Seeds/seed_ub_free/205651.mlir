module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-77> : tensor<8x1x7xi32>}> : () -> tensor<8x1x7xi32>
    %1 = tosa.reduce_product %0 {axis = 2 : i32} : (tensor<8x1x7xi32>) -> tensor<8x1x1xi32>
    %cast = tensor.cast %1 : tensor<8x1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

