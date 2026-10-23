module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<0> : tensor<6x1x4x5xi8>}> : () -> tensor<6x1x4x5xi8>
    %1 = "tosa.const"() <{values = dense<-1.817400e+02> : tensor<4x10x1x3xf32>}> : () -> tensor<4x10x1x3xf32>
    %2 = tosa.argmax %0 {axis = 1 : i32} : (tensor<6x1x4x5xi8>) -> tensor<6x4x5xi32>
    %3 = tosa.floor %1 : (tensor<4x10x1x3xf32>) -> tensor<4x10x1x3xf32>
    %4 = tosa.const_shape  {values = dense<[1, 2, 2, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.tile %3, %4 : (tensor<4x10x1x3xf32>, !tosa.shape<4>) -> tensor<4x20x2x6xf32>
    %6 = tosa.add %2, %2 : (tensor<6x4x5xi32>, tensor<6x4x5xi32>) -> tensor<6x4x5xi32>
    %7 = tosa.reverse %5 {axis = 0 : i32} : (tensor<4x20x2x6xf32>) -> tensor<4x20x2x6xf32>
    %cast = tensor.cast %6 : tensor<6x4x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<4x20x2x6xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

