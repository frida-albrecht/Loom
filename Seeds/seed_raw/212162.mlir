module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<37> : tensor<3x5xi16>}> : () -> tensor<3x5xi16>
    %1 = "tosa.const"() <{values = dense<37> : tensor<2x2xi64>}> : () -> tensor<2x2xi64>
    %2 = "tosa.const"() <{values = dense<1.996700e+02> : tensor<10xf32>}> : () -> tensor<10xf32>
    %3 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.pad %0, %3, %4 : (tensor<3x5xi16>, !tosa.shape<4>, tensor<1xi16>) -> tensor<3x5xi16>
    %6 = tosa.clamp %5 {max_val = 162 : i16, min_val = 45 : i16} : (tensor<3x5xi16>) -> tensor<3x5xi16>
    %7 = tosa.rsqrt %2 : (tensor<10xf32>) -> tensor<10xf32>
    %8 = tosa.sigmoid %7 : (tensor<10xf32>) -> tensor<10xf32>
    %9 = tosa.add %8, %8 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %10 = tosa.sigmoid %9 : (tensor<10xf32>) -> tensor<10xf32>
    %11 = tosa.reduce_sum %10 {axis = 0 : i32} : (tensor<10xf32>) -> tensor<1xf32>
    %12 = tosa.rsqrt %11 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %6 : tensor<3x5xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %12 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

