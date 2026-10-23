module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-74> : tensor<9x6x5x4xi32>}> : () -> tensor<9x6x5x4xi32>
    %1 = "tosa.const"() <{values = dense<-172> : tensor<9x6x64x4xi32>}> : () -> tensor<9x6x64x4xi32>
    %2 = tosa.concat %0, %1 {axis = 2 : i32} : (tensor<9x6x5x4xi32>, tensor<9x6x64x4xi32>) -> tensor<9x6x69x4xi32>
    %cast = tensor.cast %2 : tensor<9x6x69x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

