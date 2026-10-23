module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.082000e+01> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = "tosa.const"() <{values = dense<-129> : tensor<7x2x4xi32>}> : () -> tensor<7x2x4xi32>
    %2 = "tosa.const"() <{values = dense<-35> : tensor<7x2x1xi32>}> : () -> tensor<7x2x1xi32>
    %3 = tosa.abs %0 : (tensor<6xf32>) -> tensor<6xf32>
    %4 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<6xf32>, !tosa.shape<1>) -> tensor<18xf32>
    %6 = tosa.intdiv %1, %2 : (tensor<7x2x4xi32>, tensor<7x2x1xi32>) -> tensor<7x2x4xi32>
    %7 = tosa.exp %5 : (tensor<18xf32>) -> tensor<18xf32>
    %8 = tosa.reduce_min %7 {axis = 0 : i32} : (tensor<18xf32>) -> tensor<1xf32>
    %9 = tosa.reduce_product %6 {axis = 2 : i32} : (tensor<7x2x4xi32>) -> tensor<7x2x1xi32>
    %10 = tosa.concat %8, %8 {axis = 0 : i32} : (tensor<1xf32>, tensor<1xf32>) -> tensor<2xf32>
    %11 = tosa.const_shape  {values = dense<[3, 1, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %12 = tosa.tile %9, %11 : (tensor<7x2x1xi32>, !tosa.shape<3>) -> tensor<21x2x1xi32>
    %cast = tensor.cast %10 : tensor<2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %12 : tensor<21x2x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

