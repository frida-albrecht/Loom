module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-125> : tensor<9x6x7xi32>}> : () -> tensor<9x6x7xi32>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<9x6x7xi32>) -> tensor<9x6x7xi32>
    %cast = tensor.cast %1 : tensor<9x6x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

