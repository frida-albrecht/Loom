module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5> : tensor<8x10x4xi8>}> : () -> tensor<8x10x4xi8>
    %1 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<8x10x4xi8>) -> tensor<8x10x1xi8>
    %2 = tosa.bitwise_not %1 : (tensor<8x10x1xi8>) -> tensor<8x10x1xi8>
    %3 = tosa.const_shape  {values = dense<[8, 1, 10, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %2, %3 : (tensor<8x10x1xi8>, !tosa.shape<4>) -> tensor<8x1x10x1xi8>
    %5 = tosa.const_shape  {values = dense<[40, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.reshape %4, %5 : (tensor<8x1x10x1xi8>, !tosa.shape<2>) -> tensor<40x2xi8>
    %7 = tosa.const_shape  {values = dense<[3, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %8 = tosa.tile %6, %7 : (tensor<40x2xi8>, !tosa.shape<2>) -> tensor<120x4xi8>
    %9 = tosa.argmax %8 {axis = 0 : i32} : (tensor<120x4xi8>) -> tensor<4xi32>
    %10 = tosa.logical_left_shift %9, %9 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %11 = tosa.const_shape  {values = dense<[1, 4]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %12 = tosa.reshape %10, %11 : (tensor<4xi32>, !tosa.shape<2>) -> tensor<1x4xi32>
    %13 = tosa.arithmetic_right_shift %12, %12 {round = false} : (tensor<1x4xi32>, tensor<1x4xi32>) -> tensor<1x4xi32>
    %14 = tosa.reverse %13 {axis = 0 : i32} : (tensor<1x4xi32>) -> tensor<1x4xi32>
    %15 = tosa.reduce_product %14 {axis = 1 : i32} : (tensor<1x4xi32>) -> tensor<1x1xi32>
    %16 = tosa.abs %15 : (tensor<1x1xi32>) -> tensor<1x1xi32>
    %cast = tensor.cast %16 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

