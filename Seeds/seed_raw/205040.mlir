module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<41> : tensor<8x7x5x9xi32>}> : () -> tensor<8x7x5x9xi32>
    %1 = tosa.const_shape  {values = dense<[1, 3, 2, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<8x7x5x9xi32>, !tosa.shape<4>) -> tensor<8x21x10x27xi32>
    %3 = tosa.reduce_product %2 {axis = 3 : i32} : (tensor<8x21x10x27xi32>) -> tensor<8x21x10x1xi32>
    %cast = tensor.cast %3 : tensor<8x21x10x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

