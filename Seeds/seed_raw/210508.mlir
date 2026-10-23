module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.037000e+01> : tensor<9x10x4xf32>}> : () -> tensor<9x10x4xf32>
    %1 = "tosa.const"() <{values = dense<5.290000e+00> : tensor<9x4x10xf32>}> : () -> tensor<9x4x10xf32>
    %2 = "tosa.const"() <{values = dense<12> : tensor<i8>}> : () -> tensor<i8>
    %3 = "tosa.const"() <{values = dense<-1> : tensor<i8>}> : () -> tensor<i8>
    %4 = "tosa.const"() <{values = dense<-129> : tensor<3x9x7xi32>}> : () -> tensor<3x9x7xi32>
    %5 = "tosa.const"() <{values = dense<30> : tensor<3x9x1xi32>}> : () -> tensor<3x9x1xi32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = tosa.matmul %0, %1, %6, %7 : (tensor<9x10x4xf32>, tensor<9x4x10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<9x10x10xf32>
    %9 = tosa.floor %8 : (tensor<9x10x10xf32>) -> tensor<9x10x10xf32>
    %10 = tosa.logical_left_shift %2, %3 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %11 = tosa.reduce_product %9 {axis = 0 : i32} : (tensor<9x10x10xf32>) -> tensor<1x10x10xf32>
    %12 = tosa.intdiv %4, %5 : (tensor<3x9x7xi32>, tensor<3x9x1xi32>) -> tensor<3x9x7xi32>
    %cast = tensor.cast %10 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %11 : tensor<1x10x10xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %12 : tensor<3x9x7xi32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

