module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-152> : tensor<6x1xi32>}> : () -> tensor<6x1xi32>
    %1 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<6x1xi32>) -> tensor<6x1xi32>
    %cast = tensor.cast %1 : tensor<6x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

