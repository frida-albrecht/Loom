module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-22> : tensor<6x7x6x10xi16>}> : () -> tensor<6x7x6x10xi16>
    %1 = tosa.clamp %0 {max_val = 50 : i16, min_val = -24 : i16} : (tensor<6x7x6x10xi16>) -> tensor<6x7x6x10xi16>
    %2 = tosa.reduce_product %1 {axis = 0 : i32} : (tensor<6x7x6x10xi16>) -> tensor<1x7x6x10xi16>
    %3 = tosa.const_shape  {values = dense<[5, 84, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.reshape %2, %3 : (tensor<1x7x6x10xi16>, !tosa.shape<3>) -> tensor<5x84x1xi16>
    %5 = tosa.bitwise_or %4, %4 : (tensor<5x84x1xi16>, tensor<5x84x1xi16>) -> tensor<5x84x1xi16>
    %6 = tosa.argmax %5 {axis = 2 : i32} : (tensor<5x84x1xi16>) -> tensor<5x84xi32>
    %cast = tensor.cast %6 : tensor<5x84xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

