module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<84> : tensor<10xi16>}> : () -> tensor<10xi16>
    %1 = "tosa.const"() <{values = dense<114> : tensor<1xi16>}> : () -> tensor<1xi16>
    %2 = "tosa.const"() <{values = dense<99> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<26> : tensor<i32>}> : () -> tensor<i32>
    %4 = "tosa.const"() <{values = dense<1.126300e+02> : tensor<8x6x9x5xf32>}> : () -> tensor<8x6x9x5xf32>
    %5 = tosa.bitwise_xor %0, %1 : (tensor<10xi16>, tensor<1xi16>) -> tensor<10xi16>
    %6 = tosa.reduce_max %5 {axis = 0 : i32} : (tensor<10xi16>) -> tensor<1xi16>
    %7 = tosa.intdiv %2, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %8 = tosa.const_shape  {values = dense<0> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %10 = tosa.slice %6, %8, %9 : (tensor<1xi16>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<1xi16>
    %11 = tosa.ceil %4 : (tensor<8x6x9x5xf32>) -> tensor<8x6x9x5xf32>
    %12 = tosa.exp %11 : (tensor<8x6x9x5xf32>) -> tensor<8x6x9x5xf32>
    %13 = tosa.rsqrt %12 : (tensor<8x6x9x5xf32>) -> tensor<8x6x9x5xf32>
    %14 = tosa.reduce_min %11 {axis = 2 : i32} : (tensor<8x6x9x5xf32>) -> tensor<8x6x1x5xf32>
    %15 = tosa.sub %14, %14 : (tensor<8x6x1x5xf32>, tensor<8x6x1x5xf32>) -> tensor<8x6x1x5xf32>
    %16 = tosa.concat %14, %15 {axis = 3 : i32} : (tensor<8x6x1x5xf32>, tensor<8x6x1x5xf32>) -> tensor<8x6x1x10xf32>
    %17 = tosa.abs %14 : (tensor<8x6x1x5xf32>) -> tensor<8x6x1x5xf32>
    %cast = tensor.cast %7 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<1xi16> to tensor<*xi16>
    %cast_1 = tensor.cast %13 : tensor<8x6x9x5xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %16 : tensor<8x6x1x10xf32> to tensor<*xf32>
    %cast_3 = tensor.cast %17 : tensor<8x6x1x5xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_3) : (tensor<*xf32>) -> ()
    return
  }
}

