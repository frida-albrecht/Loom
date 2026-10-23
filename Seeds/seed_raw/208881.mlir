module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<7x8x5x2xi1>}> : () -> tensor<7x8x5x2xi1>
    %1 = "tosa.const"() <{values = dense<-1.234400e+02> : tensor<7x5x6x10xf32>}> : () -> tensor<7x5x6x10xf32>
    %2 = "tosa.const"() <{values = dense<-5.478000e+01> : tensor<1x5x1x10xf32>}> : () -> tensor<1x5x1x10xf32>
    %3 = tosa.argmax %0 {axis = 1 : i32} : (tensor<7x8x5x2xi1>) -> tensor<7x5x2xi32>
    %4 = tosa.const_shape  {values = dense<[2, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.tile %3, %4 : (tensor<7x5x2xi32>, !tosa.shape<3>) -> tensor<14x15x4xi32>
    %6 = tosa.pow %1, %2 : (tensor<7x5x6x10xf32>, tensor<1x5x1x10xf32>) -> tensor<7x5x6x10xf32>
    %cast = tensor.cast %5 : tensor<14x15x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<7x5x6x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

