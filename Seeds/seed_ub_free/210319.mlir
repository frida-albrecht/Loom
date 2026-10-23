module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<33> : tensor<7x10x3xi32>}> : () -> tensor<7x10x3xi32>
    %1 = "tosa.const"() <{values = dense<-159> : tensor<7x10x40xi32>}> : () -> tensor<7x10x40xi32>
    %2 = "tosa.const"() <{values = dense<8.380000e+00> : tensor<8x9xf32>}> : () -> tensor<8x9xf32>
    %3 = tosa.concat %0, %1 {axis = 2 : i32} : (tensor<7x10x3xi32>, tensor<7x10x40xi32>) -> tensor<7x10x43xi32>
    %4 = tosa.log %2 : (tensor<8x9xf32>) -> tensor<8x9xf32>
    %5 = tosa.abs %4 : (tensor<8x9xf32>) -> tensor<8x9xf32>
    %6 = tosa.const_shape  {values = dense<[35, 1, 86]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.reshape %3, %6 : (tensor<7x10x43xi32>, !tosa.shape<3>) -> tensor<35x1x86xi32>
    %8 = tosa.ceil %5 : (tensor<8x9xf32>) -> tensor<8x9xf32>
    %9 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %10 = tosa.tile %8, %9 : (tensor<8x9xf32>, !tosa.shape<2>) -> tensor<8x18xf32>
    %11 = tosa.maximum %5, %4 : (tensor<8x9xf32>, tensor<8x9xf32>) -> tensor<8x9xf32>
    %12 = tosa.concat %10, %10 {axis = 0 : i32} : (tensor<8x18xf32>, tensor<8x18xf32>) -> tensor<16x18xf32>
    %13 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %14 = tosa.transpose %11 {perms = array<i32: 0, 1>} : (tensor<8x9xf32>) -> tensor<8x9xf32>
    %15 = tosa.ceil %12 : (tensor<16x18xf32>) -> tensor<16x18xf32>
    %cast = tensor.cast %7 : tensor<35x1x86xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %14 : tensor<8x9xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %15 : tensor<16x18xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

