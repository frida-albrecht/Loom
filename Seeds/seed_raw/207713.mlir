module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-16> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<-65> : tensor<9xi32>}> : () -> tensor<9xi32>
    %2 = "tosa.const"() <{values = dense<-128> : tensor<9xi32>}> : () -> tensor<9xi32>
    %3 = "tosa.const"() <{values = dense<-1.267700e+02> : tensor<9x4x7x8xf32>}> : () -> tensor<9x4x7x8xf32>
    %4 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<1xi8>
    %5 = tosa.reduce_product %4 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<1xi8>
    %6 = tosa.clz %5 : (tensor<1xi8>) -> tensor<1xi8>
    %7 = tosa.logical_left_shift %6, %6 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %8 = tosa.intdiv %1, %2 : (tensor<9xi32>, tensor<9xi32>) -> tensor<9xi32>
    %9 = tosa.concat %8, %8 {axis = 0 : i32} : (tensor<9xi32>, tensor<9xi32>) -> tensor<18xi32>
    %10 = tosa.clz %9 : (tensor<18xi32>) -> tensor<18xi32>
    %11 = tosa.concat %10, %9 {axis = 0 : i32} : (tensor<18xi32>, tensor<18xi32>) -> tensor<36xi32>
    %12 = tosa.ceil %3 : (tensor<9x4x7x8xf32>) -> tensor<9x4x7x8xf32>
    %13 = tosa.log %12 : (tensor<9x4x7x8xf32>) -> tensor<9x4x7x8xf32>
    %14 = tosa.argmax %11 {axis = 0 : i32} : (tensor<36xi32>) -> tensor<i32>
    %15 = tosa.const_shape  {values = dense<5> : tensor<1xindex>} : () -> !tosa.shape<1>
    %16 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %17 = tosa.slice %11, %15, %16 : (tensor<36xi32>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<2xi32>
    %18 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %19 = tosa.reshape %14, %18 : (tensor<i32>, !tosa.shape<2>) -> tensor<1x1xi32>
    %cast = tensor.cast %7 : tensor<1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %13 : tensor<9x4x7x8xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %17 : tensor<2xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %19 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}

