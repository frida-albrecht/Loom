module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1> : tensor<5x10x8x1xi8>}> : () -> tensor<5x10x8x1xi8>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<1x1x1x1xi8>}> : () -> tensor<1x1x1x1xi8>
    %2 = tosa.maximum %0, %1 : (tensor<5x10x8x1xi8>, tensor<1x1x1x1xi8>) -> tensor<5x10x8x1xi8>
    %3 = tosa.argmax %2 {axis = 1 : i32} : (tensor<5x10x8x1xi8>) -> tensor<5x8x1xi32>
    %c1 = "tosa.const"() <{values = dense<1> : tensor<5x8x1xi32>}> : () -> tensor<5x8x1xi32>
    %s0 = tosa.maximum %3, %c1 : (tensor<5x8x1xi32>, tensor<5x8x1xi32>) -> tensor<5x8x1xi32>
    %4 = tosa.intdiv %3, %s0 : (tensor<5x8x1xi32>, tensor<5x8x1xi32>) -> tensor<5x8x1xi32>
    %5 = tosa.logical_left_shift %4, %3 : (tensor<5x8x1xi32>, tensor<5x8x1xi32>) -> tensor<5x8x1xi32>
    %cast = tensor.cast %5 : tensor<5x8x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}