module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-42> : tensor<9x7x1x8xi32>}> : () -> tensor<9x7x1x8xi32>
    %1 = "tosa.const"() <{values = dense<-9.270000e+00> : tensor<7x4xf32>}> : () -> tensor<7x4xf32>
    %2 = tosa.const_shape  {values = dense<[1, 2, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.tile %0, %2 : (tensor<9x7x1x8xi32>, !tosa.shape<4>) -> tensor<9x14x1x8xi32>
    %4 = tosa.sigmoid %1 : (tensor<7x4xf32>) -> tensor<7x4xf32>
    %5 = tosa.reduce_product %3 {axis = 3 : i32} : (tensor<9x14x1x8xi32>) -> tensor<9x14x1x1xi32>
    %6 = tosa.reverse %4 {axis = 0 : i32} : (tensor<7x4xf32>) -> tensor<7x4xf32>
    %cast = tensor.cast %5 : tensor<9x14x1x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<7x4xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

