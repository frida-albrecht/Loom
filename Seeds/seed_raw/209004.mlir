module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-32> : tensor<3x4x3x2xi32>}> : () -> tensor<3x4x3x2xi32>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<3x4x3x2xi32>) -> tensor<1x4x3x2xi32>
    %2 = tosa.const_shape  {values = dense<[1, 3, 3, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.tile %1, %2 : (tensor<1x4x3x2xi32>, !tosa.shape<4>) -> tensor<1x12x9x4xi32>
    %4 = tosa.add %3, %3 : (tensor<1x12x9x4xi32>, tensor<1x12x9x4xi32>) -> tensor<1x12x9x4xi32>
    %5 = tosa.sub %4, %4 : (tensor<1x12x9x4xi32>, tensor<1x12x9x4xi32>) -> tensor<1x12x9x4xi32>
    %6 = tosa.argmax %5 {axis = 0 : i32} : (tensor<1x12x9x4xi32>) -> tensor<12x9x4xi32>
    %cast = tensor.cast %6 : tensor<12x9x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

