module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-45> : tensor<8x8x9x6xi32>}> : () -> tensor<8x8x9x6xi32>
    %1 = tosa.reverse %0 {axis = 3 : i32} : (tensor<8x8x9x6xi32>) -> tensor<8x8x9x6xi32>
    %2 = tosa.concat %1, %1 {axis = 0 : i32} : (tensor<8x8x9x6xi32>, tensor<8x8x9x6xi32>) -> tensor<16x8x9x6xi32>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<16x8x9x6xi32>, tensor<16x8x9x6xi32>) -> tensor<16x8x9x6xi32>
    %cast = tensor.cast %3 : tensor<16x8x9x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

