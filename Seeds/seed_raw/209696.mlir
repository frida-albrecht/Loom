module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<83> : tensor<2x10x7x3xi32>}> : () -> tensor<2x10x7x3xi32>
    %1 = "tosa.const"() <{values = dense<-139> : tensor<2x1x7x1xi32>}> : () -> tensor<2x1x7x1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<2x10x7x3xi32>, tensor<2x1x7x1xi32>) -> tensor<2x10x7x3xi32>
    %3 = tosa.abs %2 : (tensor<2x10x7x3xi32>) -> tensor<2x10x7x3xi32>
    %4 = tosa.concat %3, %2 {axis = 0 : i32} : (tensor<2x10x7x3xi32>, tensor<2x10x7x3xi32>) -> tensor<4x10x7x3xi32>
    %cast = tensor.cast %4 : tensor<4x10x7x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

