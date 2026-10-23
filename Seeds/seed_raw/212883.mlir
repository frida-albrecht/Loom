module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-96.2399978> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-16> : tensor<6x9x8x2xi8>}> : () -> tensor<6x9x8x2xi8>
    %2 = tosa.log %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.argmax %1 {axis = 1 : i32} : (tensor<6x9x8x2xi8>) -> tensor<6x8x2xi32>
    %4 = tosa.reduce_product %3 {axis = 2 : i32} : (tensor<6x8x2xi32>) -> tensor<6x8x1xi32>
    %5 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<6x8x1xi32>) -> tensor<6x1x1xi32>
    %6 = tosa.identity %5 : (tensor<6x1x1xi32>) -> tensor<6x1x1xi32>
    %7 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %8 = tosa.transpose %6 {perms = array<i32: 0, 1, 2>} : (tensor<6x1x1xi32>) -> tensor<6x1x1xi32>
    %9 = tosa.tanh %2 : (tensor<f32>) -> tensor<f32>
    %10 = tosa.bitwise_xor %8, %8 : (tensor<6x1x1xi32>, tensor<6x1x1xi32>) -> tensor<6x1x1xi32>
    %11 = tosa.reduce_max %10 {axis = 1 : i32} : (tensor<6x1x1xi32>) -> tensor<6x1x1xi32>
    %12 = tosa.const_shape  {values = dense<[0, 2, 0]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %13 = tosa.const_shape  {values = dense<[6, 6, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %14 = tosa.slice %3, %12, %13 : (tensor<6x8x2xi32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<6x6x2xi32>
    %15 = tosa.argmax %11 {axis = 0 : i32} : (tensor<6x1x1xi32>) -> tensor<1x1xi32>
    %16 = tosa.ceil %2 : (tensor<f32>) -> tensor<f32>
    %17 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %18 = tosa.tile %15, %17 : (tensor<1x1xi32>, !tosa.shape<2>) -> tensor<1x1xi32>
    %cast = tensor.cast %9 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %14 : tensor<6x6x2xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %16 : tensor<f32> to tensor<*xf32>
    %cast_2 = tensor.cast %18 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}

